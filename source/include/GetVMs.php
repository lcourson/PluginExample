<?PHP
/* Copyright 2012-2020, Bergware International.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License version 2,
 * as published by the Free Software Foundation.
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 */
?>
<?
$plugin = 'vmsnapshot';
$docroot = $docroot ?: $_SERVER['DOCUMENT_ROOT'] ?: '/usr/local/emhttp';
$translations = file_exists("$docroot/webGui/include/Translations.php");

if ($translations) {
  // add translations
  $_SERVER['REQUEST_URI'] = 'vmsnapshot';
  require_once "$docroot/webGui/include/Translations.php";
} else {
  // legacy support (without javascript)
  $noscript = true;
  require_once "$docroot/plugins/$plugin/include/Legacy.php";
}
require_once "$docroot/webGui/include/Helpers.php";

unset($data);
exec("LANG='en_US.UTF8' virsh list --all --name",$data);

$now = time();
$vmnames = [];

foreach ($data as $row) {
  if (!in_array($row,$vmnames,true)) {
    $vmnames[] = $row;
    echo "<option value=\"$row\">$row</option>";
  }
}
if (!$streams) echo "<option value=\"-1\">No VMs Found</option>";
?>