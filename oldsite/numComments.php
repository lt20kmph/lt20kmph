<?php
$user = "oli";
$password = "mysql";
$database = "comments";
$table = "comments";

try {
  $pdo = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  $storyNo = $_GET['storyNo'];
  $picNo = $_GET['picNo'];
  $query = $pdo->prepare("SELECT * FROM $table WHERE storyNo = $storyNo AND picNo = $picNo");
  $query->execute();
  $nrows = $query->rowcount();
  ?>
  <?php echo $nrows;?>
  <?php
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
