<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
$conn = mysqli_connect("localhost", "root", "", "promedplus");
$new_rate=0.0;
if (!$conn) {
    die("La connexion a échoué: " . mysqli_connect_error());
}
if(isset($post["nom_docteur"]) && isset($post["rate"])){
$docteur_name=$post["nom_docteur"];
$rating=$post["rate"];
$resultat = mysqli_query($conn, "SELECT rate FROM doctors where nomPrenom = '$docteur_name'");

while ($row = mysqli_fetch_assoc($resultat)) {
    $rate = floatval($row["rate"]);
    echo "Le rate est de: " . $rate;
}
$resultat1 = mysqli_query($conn, "SELECT NombreAvis FROM doctors where nomPrenom = '$docteur_name'");

while ($row1 = mysqli_fetch_assoc($resultat1)) {
    $NombreAvis = intval($row1["NombreAvis"]);
    echo "Le NombreAvis est de: " . $NombreAvis;
}
$newNombreAvis=($NombreAvis+1);
$new_rate=((($rate*$NombreAvis)+$rating)/$newNombreAvis);
echo "new rate".$new_rate;
$sql2="UPDATE doctors SET rate = $new_rate, nombreAvis = $newNombreAvis WHERE nomprenom = '$docteur_name';";
mysqli_query($conn,$sql2);
        http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'data' => 'Merci pour votre avis']);
mysqli_close($conn);
}
?>