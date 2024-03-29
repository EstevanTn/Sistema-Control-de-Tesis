<?php

use phpDocumentor\Reflection\TypeResolver;
use phpDocumentor\Reflection\Types\Context;

require '../vendor/autoload.php';

$typeResolver = new TypeResolver();

// Will use the namespace and aliases to resolve to \phpDocumentor\Types\Resolver|Mockery\MockInterface
$context = new Context('\phpDocumentor', [ 'm' => 'Mockery' ]);
var_dump((string)$typeResolver->resolve('Types\Resolver|m\MockInterface', $context));
