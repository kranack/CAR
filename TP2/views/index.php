<?php
	include_once __DIR__.'/header.php';
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
		<div class="eight columns"> <a href="<?php echo $uri; ?>"> . </a></div>
			<div class="four columns"> </div>
		</div>		
		<?php

			foreach($files as $file) {
				echo '<div class="row"> ' .
					 '<div class="eight columns"> ' . $file . '</div>' .
                     '<div class="four columns"> ' .
                     '<div class="actions"> ' .
					 '<span class="delete"><a href="#"><i class="fa fa-trash-o"></i></a></span>' .
                     ' </div>' .
                     ' </div>' .
					 ' </div>';
			}

		include_once __DIR__.'/footer.php';
