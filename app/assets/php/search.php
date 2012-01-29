<?php
$sqlite3 = new SQLite3('localhost', 'yourUserName', 'yourPassWord', 'development');
$text = $sqlite3->real_escape_string($_GET['term']);

$query = "SELECT name FROM note WHERE name LIKE '%$text%' ORDER BY name ASC";
$result = $sqlite3->query($query);
$json = '[';
$first = true;
while($row = $result->fetch_assoc())
{
    if (!$first) { $json .=  ','; } else { $first = false; }
    $json .= '{"value":"'.$row['name'].'"}';
}
$json .= ']';
echo $json;
?>