<?php

	/*$app->get('/', function() {
		echo 'Hello there';
	});*/

	$app->get('/hello', function() {
		echo 'Hello you!';
	});

	$app->get('/hello/:name', function($name) {
		echo "Hello, $name";
	});

