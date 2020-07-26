<?php
$user = "oli";
$password = "mysql";
$database = "comments";
$table = "words";

try {
  $pdo = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  $storyNo = $_POST['storyNo'];
  $words = $_POST['words'];
  $sql = "INSERT INTO $table (storyNo, words) VALUES (?,?)";
  $stmt= $pdo->prepare($sql);
  $stmt->execute([$storyNo, $words]);
  $pdo->query($sql);
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
