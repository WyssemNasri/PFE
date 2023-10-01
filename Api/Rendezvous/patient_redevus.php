<?php
header('Content-Type: application/json');

$post = json_decode(file_get_contents('php://input'), true);
include_once "../library/function.php";
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
$conn = mysqli_connect($servername, $username, $password, $dbname);

if ($conn) {
    $nomPrenom = $post["nomPrenom"];
    $selectArray = array();
    array_push($selectArray, $nomPrenom);

    $today = date('Y-m-d'); // Obtenir la date d'aujourd'hui

    // Mettez à jour la requête SQL pour récupérer les rendez-vous acceptés avec une date ultérieure à aujourd'hui
    $sql1 = "SELECT * FROM appointments WHERE patient_name = ? AND status = 'accepted' AND date = '$today'";
    $result = dbExec($sql1, $selectArray);
    $arrJson = array();

    if ($result->rowCount() > 0) {
        $arrJson = $result->fetchAll(PDO::FETCH_ASSOC);
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        // Aucun rendez-vous futur accepté trouvé
        $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun rendez-vous futur accepté trouvé");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    // Connexion à la base de données échouée
    http_response_code(500);
    echo json_encode([
        'code' => 'error',
        "message" => "Erreur de connexion à la base de données",
    ]);
    exit;
}
?>
