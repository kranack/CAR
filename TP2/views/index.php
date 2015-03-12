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
			</div>
            <div class="one-third column">
				<div id="global_actions">
					<!--<a href="#" alt="add file"><i class="fa fa-plus"></i></a>-->
					<button id="addButton" type="button" data-toggle="modal" data-target="addFile">Add File</button>
                </div>
            </div>
        </div>
		
		<div id="file_content">		

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
					 '<span class="delete"><a href="#"><i class="fa fa-times"></i></a></span>' .
                     ' </div>' .
                     ' </div>' .
					 ' </div>';
			}
		?>
		</div>

		<div class="modal fade" id="addFile" tabindex="-1" role="dialog" aria-labelledby="addFileLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="addFileLabel"> Add File </h4>
					</div>
					<div class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<?php
		include_once __DIR__.'/footer.php';
