<?php
	include_once __DIR__.'/header.php';
?>
		<div class="row">
			<div class="twelve columns">
				<h1> List of files on FTP Server </h1>
			</div>
		</div>

		<?php
			foreach($files as $file) {
				echo '<div class="row">' .
					 '<div class="eight columns"> '. $file . '</div>' .
					 '<div class="four columns"> </div> ' .
					 '</div>';
			}
		?>

<?php
	include_once __DIR__.'/footer.php';
