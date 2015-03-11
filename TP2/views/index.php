<?php
	include_once __DIR__.'/header.php';
    $path = ($path=="/")? "" : $path;
    $tmp = explode('/',$path);
    $last = array_pop($tmp); // null if empty
	$previous = (count($tmp)==1)? "/" : implode('/',$tmp);
?>

		<div class="row">
			<div class="twelve columns">
				<h1> List of files on FTP Server </h1>
			</div>
        </div>

        <div class="row">
			<div class="two-thirds column">
				<a href="/" alt="root"> Return to root </a>
			</div>
            <div class="one-third column">
                <div id="global-actions">
                </div>
            </div>
        </div>
		
		<div class="row">
		<div class="eight columns"> <a href="<?php echo $previous; ?>"> .. </a></div>
			<div class="four columns"> </div>
		</div>
		<?php

			foreach($files as $file) {
				echo '<div class="row item"> ' .
					 '<div class="eight columns"><a href="'.$path.'/'.$file.'">' . $file . '</a></div>' .
                     '<div class="four columns"> ' .
                     '<div class="actions"> ' .
					 '<span class="delete"><a href="#"><i class="fa fa-trash-o"></i></a></span>' .
                     ' </div>' .
                     ' </div>' .
					 ' </div>';
			}

		include_once __DIR__.'/footer.php';
