<?php
    /**
     * Class Loader
     *
     * Load all external classes in class directory
     *
     * @author Damien Calesse
     * @author Pierre Leroy
     */

	foreach (glob("class/*.php") as $filename)
	{
	    include_once $filename;
	}

