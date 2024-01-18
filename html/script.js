document.addEventListener('DOMContentLoaded', function () {
    const menu = document.getElementById('menu');
    
    let showJobs = false;
    
    const switchbutton = document.getElementById('switch-btn');

    switchbutton.addEventListener('click', function () {
        if (showJobs) {
            showCards();
            showJobs = false;
        } else {
            showJobsf();
            showJobs = true;
        }
    });

    $(document).ready(function() {
        items.forEach(function(item) {
            var itemHTML =
                '<div class="item-container">' +
                '<div class="item">' +
                '<img src="' + item.image + '" alt="' + item.title + '" class="item-image">' +
                '<div class="item-details">' +
                '<h1 class="item-title">' + item.title + '</h1>' +
                '<p class="item-description">' + item.description + '</p>' +
                '</div></div>' +
                '</div>' +
                '<button class="buy-button" onclick="' + item.action + '(\'' + item.id + '\')">Vásárlás</button>';
            $('#items').append(itemHTML);
        });
    });

    $(document).ready(function() {
        jobs.forEach(function(job) {
            var jobHTML =
                '<div class="item-container">' +
                '<div class="item">' +
                '<img src="' + job.image + '" alt="' + job.title + '" class="item-image">' +
                '<div class="item-details">' +
                '<h1 class="item-title">' + job.title + '</h1>' +
                '<p class="item-description">' + job.description + '</p>' +
                '</div></div>' +
                '</div>' +
                '<button class="buy-button" onclick="' + job.action + '(\'' + job.id + '\')">Felvesz</button>';
            $('#jobs').append(jobHTML);
        });
    });
    
    function showJobsf() {
        $("#menu").fadeOut(function() {
            $("#items").hide();
            $("#jobs").show();
            $("h2").text("Városháza | Munka felvétel");
            $("#menu").fadeIn();
        });
    }

    function showCards() {
        $("#menu").fadeOut(function() {
            $("#jobs").hide();
            $("#items").show();
            $("h2").text("Városháza | Igazolvány vásárlás");
            $("#menu").fadeIn();
        });
    }   

    window.addEventListener('keyup', function (event) {
        if (event.key === 'Escape') {
            closeMenu();
        }
    });

    window.addEventListener('message', function (event) {
        const data = event.data;
        if (data.action === 'open') {
            menu.style.display = 'block';
        } else if (data.action === 'toggleMenu') {
            if (data.state) {
                openMenu();
            } else {
                closeMenu();
            }
        }
    });
    function openMenu() {
        menu.style.display = 'block';
    }
    function closeMenu() {
        menu.style.display = 'none';
        $.post('https://sikosz_cityhall/closeMenu', JSON.stringify({}));
    }

    window.buyItem = function (itemId) {
        fetch(`https://sikosz_cityhall/buyItem`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ itemId: itemId }),
        });
    };

    window.setJob = function (jobId) {
        fetch(`https://sikosz_cityhall/setJob`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ jobId: jobId }),
        });
    };
});