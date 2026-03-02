
**BATCH ASSET MOVE**

Using `move_assets_from_list.rb`in services, send move requests to SonyCi API


_Requirements_:

1. `gbh_sony_ci_one_off_scripts` repo copied locally
2. Authentication credentials in `ci.yml`file
3. `sony_ci_api_rewrite` repo in local path defined in `Gemfile`

_Directions_:
1. Create .txt file with list of filenames you want to move, including extensions (files must all be located in the same parent folder in SonyCi). Save in `gbh_sony_ci_one_off_scripts`
2. In terminal `cd gbh_sony_ci_one_off_scripts`
3. `bundle exec ruby sony_ci_cli.rb move_from_list` + `txt file with filenames listed` + `Source SonyCi Folder ID containing files` + `destination SonyCi Folder ID or Workspace ID` `--dry-run`

_For example:_ 

`bundle exec ruby sony_ci_cli.rb move_from_list files_to_move.txt 32423lkj35325325 23432kj23523j2 --dry-run`
Output will provide the number of assets/filenames matched and location files would be moved to

4. When you have confirmed the files you want to move and the destination folder are correct, run

  `bundle exec ruby sony_ci_cli.rb move_from_list files_to_move.txt 32423lkj35325325 23432kj23523j2 --no-dry-run`
  
  The provided output will give a summary of what assets were moved (by SonyCi ID) and report any errors.
