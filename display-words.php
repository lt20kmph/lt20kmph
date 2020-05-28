<?php
$user = "oli";
$password = "mysql";
$database = "comments";
$table = "words";

try {
  $pdo = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  $storyNo = $_GET['storyNo'];
  $query = $pdo->prepare("SELECT words FROM $table WHERE storyNo = $storyNo");
  $query->execute();
  $words=$query->fetch(PDO::FETCH_ASSOC);
  ?>
  <?php echo $words['words'];?>
  <?php
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
