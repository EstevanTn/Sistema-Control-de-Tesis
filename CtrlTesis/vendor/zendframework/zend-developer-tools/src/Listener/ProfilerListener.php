<?php
/**
 * Zend Developer Tools for Zend Framework (http://framework.zend.com/)
 *
 * @link       http://github.com/zendframework/ZendDeveloperTools for the canonical source repository
 * @copyright  Copyright (c) 2005-2014 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd New BSD License
 */

namespace ZendDeveloperTools\Listener;

use Zend\EventManager\EventManagerInterface;
use Zend\EventManager\ListenerAggregateInterface;
use Zend\EventManager\ListenerAggregateTrait;
use Zend\Mvc\MvcEvent;
use Zend\ServiceManager\Exception\ServiceNotFoundException;
use Zend\ServiceManager\ServiceLocatorInterface;
use ZendDeveloperTools\Options;
use ZendDeveloperTools\Profiler;

/**
 * Profiler Listener
 *
 * Listens to the MvcEvent::EVENT_FINISH event and starts collecting data.
 *
 */
class ProfilerListener implements ListenerAggregateInterface
{
    use ListenerAggregateTrait;

    /**
     * @var ServiceLocatorInterface
     */
    protected $serviceLocator;

    /**
     * @var Options
     */
    protected $options;

    /**
     * Constructor.
     *
     * @param ServiceLocatorInterface $serviceLocator
     * @param Options                 $options
     */
    public function __construct(ServiceLocatorInterface $serviceLocator, Options $options)
    {
        $this->options        = $options;
        $this->serviceLocator = $serviceLocator;
    }

    /**
     * {@inheritdoc}
     */
    public function attach(EventManagerInterface $events, $priority = 1)
    {
        $this->listeners[] = $events->attach(
            MvcEvent::EVENT_FINISH,
            [$this, 'onFinish'],
            Profiler::PRIORITY_PROFILER
        );
    }

    /**
     * MvcEvent::EVENT_FINISH event callback
     *
     * @param  MvcEvent $event
     * @throws ServiceNotFoundException
     */
    public function onFinish(MvcEvent $event)
    {
        $strict     = $this->options->isStrict();
        $collectors = $this->options->getCollectors();
        $report     = $this->serviceLocator->get('ZendDeveloperTools\Report');
        $profiler   = $this->serviceLocator->get('ZendDeveloperTools\Profiler');

        $profiler->setErrorMode($strict);

        foreach ($collectors as $name => $collector) {
            if ($this->serviceLocator->has($collector)) {
                $profiler->addCollector($this->serviceLocator->get($collector));
                continue;
            }

            $error = sprintf('Unable to fetch or create an instance for %s.', $collector);
            if ($strict === true) {
                throw new ServiceNotFoundException($error);
            }
            $report->addError($error);
        }

        $profiler->collect($event);
    }
}
