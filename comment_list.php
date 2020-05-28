<?php
$user = "oli";
$password = "mysql";
$database = "comments";
$table = "comments";

try {
  $pdo = new PDO("mysql:host=localhost;dbname=$database", $user, $password);
  $storyNo = $_GET['storyNo'];
  $picNo = $_GET['picNo'];
  $query = $pdo->prepare("SELECT * FROM $table WHERE storyNo = $storyNo AND picNo = $picNo ORDER BY time DESC");
  /* $query = $pdo->prepare("SELECT * FROM $table WHERE storyNo = 20 AND picNo = 5 ORDER BY time DESC"); */
  $query->execute();
  $nrows = $query->rowcount();
  if($nrows > 0)
  {
  	while($row=$query->fetch(PDO::FETCH_ASSOC))
  	{
                ?>
                <div class="Comments">
		<div class="Name"><?php echo $row['name'];?></div>
		<div class="Time"><?php echo $row['time'];?></div>
		<div class="Comment"><?php echo $row['comment'];?></div>
                </div>
		<?php
  	}
  }
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
