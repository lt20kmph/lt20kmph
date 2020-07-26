<?php
$user = "oli";
$password = "mysql";
$database = "comments";
$table = "captions";

try {
  $pdo = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  $storyNo = $_GET['storyNo'];
  $picNo = $_GET['picNo'];
  $query = $pdo->prepare("SELECT cap FROM $table WHERE storyNo = $storyNo AND picNo = $picNo");
  $query->execute();
  $cap=$query->fetch(PDO::FETCH_ASSOC);
  ?>
  <?php echo $cap['cap'];?>
  <?php
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
