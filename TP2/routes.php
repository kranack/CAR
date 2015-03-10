<?php


	foreach (glob("routes/*.php") as $filename)
	{
	    include_once $filename;
	}

