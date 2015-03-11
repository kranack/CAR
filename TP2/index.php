<?php
    /**
     * Main file
     *
     * Load Slim Framework and all external classes
     * Then Create a new server with Slim
     * Load the routes
     *
     * @author Damien Calesse
     * @author Pierre Leroy
     */
	error_reporting(E_ALL & ~E_NOTICE);

	require __DIR__.'/vendor/autoload.php';
	require __DIR__.'/includes.php';
		
	use Slim\Slim;

	$app = new Slim();
	$app->config('debug', true);
	$app->config('templates.path', './views');

	$log = $app->getLog();
	$log->setEnabled(true);

	require __DIR__.'/routes.php';

	$app->run();
