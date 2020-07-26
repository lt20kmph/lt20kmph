<?php
$user = "oli";
$password = "mysql";
$database = "comments";
$table = "comments";

try {
  $pdo = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  $storyNo = $_POST['storyNo'];
  $picNo = $_POST['picNo'];
  $name = $_POST['name'];
  $comment = $_POST['comment'];
  $sql = "INSERT INTO $table (storyNo, picNo, name, comment) VALUES (?,?,?,?)";
  $stmt= $pdo->prepare($sql);
  $stmt->execute([$storyNo, $picNo, $name, $comment]);
  $pdo->query($sql);
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
