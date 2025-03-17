function checkData(x, y, r) {
    let resp = {
        isValid: true,
        reason: "Корректные данные"
    }

    if (isNaN(+x) || isNaN(+y) || isNaN(+r)) {
        resp.isValid = false;
        resp.reason = "Невалидные данные"
    }

    if (+x < -5) {
        resp.isValid = false;
        resp.reason = "x должен быть больше или равен -5 (x=" + +x + ")"
    }

    if (+x > 5) {
        resp.isValid = false;
        resp.reason = "x должен быть меньше или равен 5 (x=" + +x + ")";
    }

    if (+y < -5) {
        resp.isValid = false;
        resp.reason = "y должен быть больше или равен -5 (y=" + +y + ")";
    }
    if (+y > 3) {
        resp.isValid = false;
        resp.reason = "y должен быть меньше или равен 3 (y=" + +y + ")";
    }

    return resp;
}

document.addEventListener('DOMContentLoaded', function () {
    const yInput = document.getElementById('y');
    const rInput = document.querySelector('.checkbox-group input[name="r"]:checked');

    yInput.addEventListener('input', function () {
        validateInput(yInput, -3, 3);
    });

    rInput.addEventListener('input', function () {
        validateInput(rInput, 1, 3);
    });
});

function validateInput(inputElement, underBound, upperBound) {
    const value = inputElement.value;
    const errorMessage = inputElement.nextElementSibling;

    if (!isNaN(value) && value >= underBound && value <= upperBound) {
        errorMessage.textContent = '';
        inputElement.classList.remove('input-error');
    } else {
        errorMessage.textContent = `Введите число от ${underBound} до ${upperBound}.`;
        inputElement.classList.add('input-error');
    }
}

function resetForm() {
    document.getElementById("y").value = "";


    document.getElementById("selectedX").value = "";
    const xButtons = document.querySelectorAll("#buttonForm .button-group button");
    xButtons.forEach(button => button.classList.remove("active"));

    document.querySelectorAll('.button-group button').forEach(button => {
        button.style.backgroundColor = ""; // Сброс к стандартному цвету
        button.style.color = "";
    });

    const checkboxesR = document.querySelectorAll("input[name='r']");
    checkboxesR.forEach(checkbox => checkbox.checked = false);

    document.getElementById("submitButton").disabled = true;

    const errorMessages = document.querySelectorAll(".error-message");
    errorMessages.forEach(message => message.textContent = "");
}

function checkInputs() {
    const selectedX = document.getElementById('selectedX').value;
    const y = document.getElementById('y').value.trim();
    const selectedR = document.querySelector('.checkbox-group input[name="r"]:checked');

    const submitButton = document.getElementById('submitButton');

    if (selectedX !== '' && y !== '' && selectedR && !(y > 3 || y < -3)) {
        submitButton.disabled = false;
    } else {
        submitButton.disabled = true;
    }
}

// хз ну
function toggleCheckboxes(clickedCheckbox) {
    console.log("Checkbox clicked:", clickedCheckbox.value);

    document.querySelectorAll('.checkbox-group input[name="r"]').forEach(checkbox => {
        if (checkbox !== clickedCheckbox) {
            checkbox.checked = false;
        }
    });

    clickedCheckbox.checked = true;

    console.log("Checked checkboxes:",
        Array.from(document.querySelectorAll('.checkbox-group input[name="r"]:checked'))
            .map(cb => cb.value)
    );
    checkInputs();
}



function setXValue(value) {
    document.getElementById("selectedX").value = value;
    highlightSelectedX(value);
    checkInputs();
}

// подсыветка
function highlightSelectedX(value) {
    document.querySelectorAll('.button-group button').forEach(button => {
        if (button.textContent === value.toString()) {
            button.style.backgroundColor = "red"; // Зелёный цвет для выбранной кнопки
            button.style.color = "black";
        } else {
            button.style.backgroundColor = ""; // Сброс к стандартному цвету
            button.style.color = "";
        }
    });
}

function drawPoint(x, y, r, result) {
    let circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
    circle.setAttribute("cx", x * 170 / r + 200);
    circle.setAttribute("cy", -y * 170 / r + 200);
    circle.setAttribute("r", 4);

    circle.style.stroke = "black";
    circle.style["stroke-width"] = "1px";
    circle.style.fill = result? "#0ecc14" : "#d1220f";

    $("#graph").append(circle);
}



$("#graph").on("click", function (e) {
    let rElement = document.querySelector('.checkbox-group input[name="r"]:checked');
    if (!rElement) {
        alert("Невозможно вычислить попадание");
        return;
    }
    let rValue = parseFloat(rElement.value);
    let calculatedX = (e.pageX - $(this).offset().left - $(this).width() / 2) / 150 * rValue;
    let calculatedY = ($(this).height() / 2 - (e.pageY - $(this).offset().top)) / 150 * rValue;


    let result = checkData(calculatedX, calculatedY, rValue)
    if (!result.isValid) {
        alert(result.reason);
        return;
    }

    fetch('/server/check', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `x=${calculatedX}&y=${calculatedY}&r=${rValue}`
    })
        .then(response => response.text())
        .then(html => {
            document.body.innerHTML = html;
        })
        .catch(error => console.error('Ошибка:', error));
});
