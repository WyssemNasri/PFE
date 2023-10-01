<?php
function dbQuery($sql, $params) {
    // Connexion à la base de données (ajustez les paramètres en fonction de votre configuration)
    $dsn = "mysql:host=localhost;dbname=promedplus;charset=utf8";
    $username = "root";
    $password = "";

    try {
        $pdo = new PDO($dsn, $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Préparez et exécutez la requête SQL avec les paramètres
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);

        // Récupérez les résultats sous forme de tableau associatif
        $result = $stmt->fetch(PDO::FETCH_ASSOC);

        // Fermez la connexion
        $pdo = null;

        return $result;
    } catch (PDOException $e) {
        // Gestion des erreurs de connexion à la base de données
        return false;
    }
}

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
include_once "../library/function.php"; // Assurez-vous que le chemin vers votre fichier de fonctions est correct.
if (isset($post["cle"]) && isset($post["password"])) {
    $cle = $post["cle"];
    $password = $post["password"];
    $NomPrenom = ($post["NomPrenom"] !== "") ? $post["NomPrenom"] : null;
    $email = ($post["email"] !== "") ? $post["email"] : null;
    $phone = ($post["phone"] !== "") ? $post["phone"] : null;

    var_dump($NomPrenom); // Déboguer la valeur de $NomPrenom
    var_dump($email); // Déboguer la valeur de $email
    var_dump($phone); // Déboguer la valeur de $phone

    // Construisez la requête SQL pour récupérer les valeurs existantes
    $sql_select = "SELECT NomPrenom, email, numero FROM users WHERE cle = ? AND password = ?";
    $select_params = array($cle, $password);

    // Exécutez la requête SELECT
    $existing_values = dbQuery($sql_select, $select_params);

    if ($existing_values !== false) {
        // Utilisez les valeurs existantes si les champs sont null
        $NomPrenom = isset($post["NomPrenom"]) ? $post["NomPrenom"] : $existing_values["NomPrenom"];
        $email = isset($post["email"]) ? $post["email"] : $existing_values["email"];
        $phone = isset($post["phone"]) ? $post["phone"] : $existing_values["numero"];

        $updateArray = array();

        // Construisez la requête SQL en fonction des champs définis
        $sql_update = "UPDATE users SET";
        if ($NomPrenom !== null) {
            $sql_update .= " NomPrenom = ?,";
            array_push($updateArray, $NomPrenom);
        }
        if ($email !== null) {
            $sql_update .= " email = ?,";
            array_push($updateArray, $email);
        }
        if ($phone !== null) {
            $sql_update .= " numero = ?,";
            array_push($updateArray, $phone);
        }
        $sql_update = rtrim($sql_update, ','); // Supprimez la virgule en trop à la fin de la requête.

        $sql_update .= " WHERE cle = ? AND password = ?";
        array_push($updateArray, $cle, $password);

        // Exécutez la mise à jour
        $result = dbExec($sql_update, $updateArray);

        if ($result) {
            http_response_code(200);
            echo json_encode([
                'code' => 'success',
                'message' => "Utilisateur mis à jour avec succès"
            ]);
        } else {
            http_response_code(400);
            echo json_encode([
                'code' => 'error',
                'message' => "Erreur lors de la mise à jour de l'utilisateur"
            ]);
        }
    } else {
        http_response_code(400);
        echo json_encode([
            'code' => 'error',
            'message' => "Erreur lors de la récupération des valeurs existantes"
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
