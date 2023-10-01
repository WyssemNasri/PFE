<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);

include_once "../library/function.php";
if (isset($post["cle"]) && isset($post["password"])) {
    $cle = $post["cle"];
    $password = $post["password"];
    $deleteArray = array();

    array_push($deleteArray, $cle, $password);
    $sql = "DELETE FROM users WHERE cle = ? AND password = ?";
    $result = dbExec($sql, $deleteArray);

    if ($result) {
        http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'message' => "Utilisateur supprimé avec succès"
        ]);
    } else {
        http_response_code(400);
        echo json_encode([
            'code' => 'error',
            'message' => "Erreur lors de la suppression de l'utilisateur"
        ]);
    }
} else {
    http_response_code(400);
    echo json_encode([
        'code' => 'fail',
        'message' => "Erreur : Champs 'cle' ou 'password' manquants"
    ]);
}
?>
