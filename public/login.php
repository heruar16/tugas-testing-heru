<?php
session_start();
require 'koneksi.php';

$error = "";

if (isset($_POST['login'])) {

    $username = $_POST['username'];
    $password = $_POST['password'];

    $q = mysqli_query($koneksi, "SELECT * FROM users WHERE username='$username'");
    $data = mysqli_fetch_assoc($q);

    if ($data) {

        if (password_verify($password, $data['password'])) {
            $_SESSION['user'] = $data['username'];
            header("Location: beranda.php");
            exit();
        } else {
            $error = "Password salah!";
        }

    } else {
        $error = "Username tidak ditemukan!";
    }
}
?>
<!DOCTYPE html>
<html>
<body>
<h2>Login</h2>

<?php if ($error) echo "<p style='color:red'>$error</p>"; ?>

<form method="POST">
    <input name="username" placeholder="Username" required><br><br>
    <input name="password" type="password" placeholder="Password" required><br><br>
    <button name="login">Login</button>
</form>

<p>Belum punya akun? <a href="register.php">Daftar disini</a></p>
</body>
</html>
