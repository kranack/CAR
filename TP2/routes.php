<?php
    /**
     *  Routes Loader
     *
     * Load all the routes files in routes directory
     *
     * @author Damien Calesse
     * @author Pierre Leroy
     */

	foreach (glob("routes/*.php") as $filename)
	{
	    include_once $filename;
	}

