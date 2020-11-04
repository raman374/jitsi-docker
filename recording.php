<?php
require 'vendor/autoload.php';
use Aws\S3\S3Client;

$file = '';
$files = $a = scandir($argv[1]);
foreach ($files as $rec) { if($rec !== '.' && $rec !== '..' && $rec !== 'metadata.json') { $file = $rec; }}
$names = explode('_', $file);
$room = $names[0];
$folder = str_replace('/srv/recordings/','',$argv[1]);

echo "\n".$file;
echo "\n".$room;
echo "\n".$event = md5(rand(11111,99999).date('Ymdhis').$room.$file).'.mp4';
echo "\n".$thumb = md5(rand(11111,99999).date('Ymdhis').$room.$file).'.png';

$client = new S3Client([
        'version' => 'latest',
        'region' => 'us-east-1',
        'endpoint' => 'http://s3.wasabisys.com',
        'credentials'=> ['key' => 'J6HTJQ5NDNVGP7LTOQUO', 'secret' => 'A4CkvhrrloAIl0QEF3scZkDMADA6fLgrzRVjRJ3e',],]);

$client->putObject([
        'Content-Type' => 'application/octet-stream',
        'Bucket' => 'recording',
        'Key' => $event,
        'SourceFile'=> $argv[1].'/'.$file,
        'ACL' => 'public-read'
]);

// $ch = curl_init('https://meet-api.cap-tek.com/api/post/recording');
// $payload = json_encode(array('room' => $room, 'file' => 'https://s3.wasabisys.com/recording/'.$event, 'duration' => 0, 'thumbnail' => ''));
// curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
// curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
// curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
// curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// curl_setopt($ch, CURLOPT_TIMEOUT, 1);
// $result = curl_exec($ch);
// curl_close($ch);

$ch = curl_init('https://domik.myvirtualway.com/api/Login/SaveRecordng');
$payload = json_encode(array('deviceUID' => $room, 'URL' => 'https://s3.wasabisys.com/recording/'.$event));
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 1);
$result = curl_exec($ch);
curl_close($ch);

$ch = curl_init('https://stl-api.cap-tek.com/api/recording');
$payload = json_encode(array('room' => $room, 'file' => 'https://s3.wasabisys.com/recording/'.$event));
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 1);
$result = curl_exec($ch);
curl_close($ch);

// $ch = curl_init('https://goidd-api.cap-tek.com/api/post/recording');
// $payload = json_encode(array('room' => $room, 'file' => 'https://s3.wasabisys.com/recording/'.$event, 'duration' => 0, 'thumbnail' => ''));
// curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
// curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
// curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
// curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// curl_setopt($ch, CURLOPT_TIMEOUT, 1);
// $result = curl_exec($ch);
// curl_close($ch);

// $ch = curl_init('https://webby-api.cap-tek.com/api/post/recording');
// $payload = json_encode(array('room' => $room, 'file' => 'https://s3.wasabisys.com/recording/'.$event, 'duration' => 0, 'thumbnail' => ''));
// curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
// curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
// curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
// curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// curl_setopt($ch, CURLOPT_TIMEOUT, 1);
// $result = curl_exec($ch);
// curl_close($ch);

// $ch = curl_init('https://workaction-api.cap-tek.com/api/post/recording');
// $payload = json_encode(array('room' => $room, 'file' => 'https://s3.wasabisys.com/recording/'.$event, 'duration' => 0, 'thumbnail' => ''));
// curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
// curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
// curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
// curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
// curl_setopt($ch, CURLOPT_TIMEOUT, 1);
// $result = curl_exec($ch);
// curl_close($ch);