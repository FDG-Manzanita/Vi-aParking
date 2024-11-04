<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Estacionamientos por Sector</title>

    <!-- Enlace a Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Enlace a Font Awesome para los iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Enlace a tu archivo CSS personalizado -->
    <link rel="stylesheet" href="styles.css">

    <style>
        body {
            background-color: #f8f9fa; /* Color de fondo */
        }

        .navbar {
            background: linear-gradient(to right, #1E3C72, #2A5298); /* Gradiente para la barra de navegación */
            color: white;
        }

        .navbar .nav-link {
            color: white; /* Cambiar el color del texto de los enlaces de navegación a blanco */
        }

        .container {
            margin-top: 20px;
            padding-left: 15px; /* Margen de 15px a la izquierda */
            padding-right: 15px; /* Margen de 15px a la derecha */
        }

        .chart-container {
            width: 100%; /* Ajustar el gráfico al contenedor */
            height: 400px; /* Altura del gráfico */
            margin-top: 20px; /* Espacio arriba del gráfico */
        }

        /* Estilos adicionales para el menú */
        .drawer {
            position: fixed;
            top: 56px; /* Altura del navbar */
            left: -250px; /* Inicialmente oculto */
            width: 250px;
            height: calc(100% - 56px); /* Altura completa menos el navbar */
            background: #343a40; /* Fondo oscuro */
            transition: left 0.3s ease;
            z-index: 999; /* Asegúrate de que esté por encima de otros elementos */
        }

        .drawer.open {
            left: 0; /* Mostrar el drawer */
        }

        .drawer ul {
            padding: 20px;
            list-style: none;
        }

        .drawer ul li {
            color: white;
            padding: 10px 0;
        }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="#">Dashboard</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <button class="btn btn-outline-light ml-auto" id="toggleDrawer">Toggle Menu</button> <!-- Botón para abrir/cerrar el drawer -->
    </nav>

    <div class="drawer" id="drawer">
        <ul>
            <li><a class="nav-link" href="/dashboard">Dashboard 1</a></li>
            <li><a class="nav-link" href="/dashboard2">Dashboard 2</a></li>
            <li><a class="nav-link" href="/dashboard3">Dashboard 3</a></li>
            <li><a class="nav-link" href="/login">Cerrar Sesión</a></li>
        </ul>
    </div>

    <div class="container">
        <h1 class="text-center">Estacionamientos por Sector</h1>
        <div class="chart-container">
            <canvas id="estacionamientosChart"></canvas>
        </div>
    </div>

    <script>
        const ctx = document.getElementById('estacionamientosChart').getContext('2d');
        const sectores = @json($sectores); // Suponiendo que tienes estas variables definidas en tu controlador
        const totales = @json($totales);

        const estacionamientosChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: sectores,
                datasets: [{
                    label: 'Total de Estacionamientos',
                    data: totales,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Función para abrir/cerrar el drawer
        document.getElementById('toggleDrawer').addEventListener('click', function() {
            const drawer = document.getElementById('drawer');
            drawer.classList.toggle('open');
        });
    </script>

    <!-- jQuery y Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
