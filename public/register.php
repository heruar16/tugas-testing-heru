<?php
require 'koneksi.php';

$msg = "";

if (isset($_POST['daftar'])) {
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    $q = mysqli_query($koneksi, "INSERT INTO users VALUES(NULL, '$username', '$password')");

    if ($q) {
        $msg = "Registrasi berhasil!";
    } else {
        $msg = "Gagal mendaftar.";
    }
}
?>
<!DOCTYPE html>
<html>
<body>
<h2>Registrasi</h2>

<?php if ($msg) echo "<p style='color:green'>$msg</p>"; ?>

<form method="POST">
    <input name="username" placeholder="Username" required><br><br>
    <input name="password" type="password" placeholder="Password" required><br><br>
    <button name="daftar">Daftar</button>
</form>

</body>
</html>
