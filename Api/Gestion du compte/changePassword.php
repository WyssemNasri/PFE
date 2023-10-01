<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);


// Vérifiez si les données ont été reçues en tant que méthode POST JSON



    if (isset($post["cle"]) && isset($post["last_password"]) && isset($post["new_password"])) {
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "promedplus";

        $conn = mysqli_connect($servername, $username, $password, $dbname);

        $cle = $post["cle"];
        $Last_password = $post["last_password"];
        $new_password = $post["new_password"];

        // Échappez les valeurs pour éviter les injections SQL (ne jamais faire confiance aux données de l'utilisateur)
        $cle = mysqli_real_escape_string($conn, $cle);
        $Last_password = mysqli_real_escape_string($conn, $Last_password);
        $new_password = mysqli_real_escape_string($conn, $new_password);

        // Vous devez remplacer "nomPrenom" par le nom de la colonne appropriée dans votre table Users
        // Assurez-vous que la colonne de nomPrenom est unique pour identifier l'utilisateur correctement
        $sql_select = "SELECT * FROM Users WHERE cle = '$cle'";
        $result = mysqli_query($conn, $sql_select);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $pass = $row["password"];
            if ($pass == $Last_password) {
                // Vous devez remplacer "nomPrenom" par le nom de la colonne appropriée dans votre table Users
                $sql_update = "UPDATE Users SET password='$new_password' WHERE cle = '$cle'";
                $result_update = mysqli_query($conn, $sql_update);

                if ($result_update) {
                    http_response_code(200);
                    echo json_encode([
                        'code' => 'success',
                        'data' => 'Mot de passe modifié',
                    ]);
                } else {
                    http_response_code(500);
                    echo json_encode([
                        'code' => 'error',
                        'data' => 'Erreur lors de la mise à jour du mot de passe',
                    ]);
                }
                exit;
            } else {
                http_response_code(400);
                echo json_encode([
                    'code' => 'failed',
                    'data' => 'Mot de passe incorrect',
                ]);
                exit;
            }
        } else {
            http_response_code(400);
            echo json_encode([
                'code' => 'failed',
                'data' => 'Clé de sécurité incorrecte',
            ]);
            exit;
        }
    } else {
        http_response_code(400);
        echo json_encode([
            'code' => 'failed',
            'data' => 'Champs manquants',
        ]);
        exit;
    }

?>
