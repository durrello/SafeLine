$(document).ready(function() {
    console.log("fffff")

    const firebaseConfig = {
        apiKey: "AIzaSyB1fKMyJMftJh7VCKsJttqDTc3-Q1kPFoM",
        authDomain: "stay-safe-1805f.firebaseapp.com",
        projectId: "stay-safe-1805f",
        storageBucket: "stay-safe-1805f.appspot.com",
        messagingSenderId: "88640149780",
        appId: "1:88640149780:web:a74b32484d56d9d2c7ca01",
        measurementId: "G-7VV82VB1D1"
    };

    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    firebase.analytics();

    var firestore = firebase.firestore();


    var allComplain = []
    var complain = []

    // console.log(firestore.collection("markers").where('id', '==', 'rggfsNEGmoMtzUgB').get(), "iiiiiiiiiiiiiiiii");



    firestore.collection("markers")
        .onSnapshot((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                console.log("Current data: ", doc.data());
            });
            swal({
                title: "NEW REPORT",
                text: "A new report has been made please Attend to it.",
                icon: "success",
                button: "Attend",
                timer: 3000
            });
            fetchData();
        });

    fetchData = () => {
        $("#allReports").empty();

        firestore.collection("markers").orderBy("state").get().then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                console.log(JSON.stringify(doc.data()), "00000000000000")
                allComplain.push(JSON.stringify(doc.data().newMarker) || JSON.stringify(doc.data()))
            })

            allComplain.forEach(el => {
                console.log(JSON.parse(el), "88888888888888")
                complain.push(JSON.parse(el))
            })

            // console.log(complain, "-----------s")
            complain.sort((a, b) => {
                return a.date - b.date
            });

            var i = 1
            complain.forEach(el2 => {
                $("#allReports").append(
                    `<div class="col-md-3" id="report-${el2.id}">
                    <hr id="hr-${el2.id}" style="background-color: red; height:2px; margin-bottom: -2px;">
                    <div class="report-card text-center">
                        <img src="${el2.url}" class="img img-responsive report-image" >
                        <div class="report-content">
                            <div class="report-name">${el2.incident}
                                <p id="location">${el2.location}</p>
                            </div>
                            <div class="report-description">${el2.summary}</div>
                            <div class="row">
                                <div class="col-xs-4">
                                    <div class="report-overview">
                                        <div style="float:left">
                                            <h4>STATUS</h4>
                                            <p id="statusMessage-${el2.id}">Checking....</p>
                                        </div>

                                        <div style="float:right">
                                            <p>
                                                <button id="button-${el2.id}" class="btn btn-danger" onclick="handleReport(this)">Attend</button>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-dark">
                         <small class="text-muted">${new Date(el2.date).toDateString()} |  ${new Date(el2.date).toLocaleTimeString()}</small>
                        </div>
                    </div>
                </div>`
                );
                if ((el2.status == false) && el2.state == false) {
                    $(`#statusMessage-${el2.id}`).text("Active");
                    $(`#statusMessage-${el2.id}`).css('color', 'green');
                    $(`#hr-${el2.id}`).css('background', 'green');

                }
                if ((el2.status == true) && el2.state == false) {
                    $(`#statusMessage-${el2.id}`).text("Attending");
                    $(`#statusMessage-${el2.id}`).css('color', 'yellow');
                    $(`#hr-${el2.id}`).css('background', 'yellow');
                    $(`#button-${el2.id}`).removeClass('btn-danger');
                    $(`#button-${el2.id}`).addClass('btn-primary');
                    $(`#button-${el2.id}`).text("Attended");
                    $(`#button-${el2.id}`).removeAttr('onclick');
                    $(`#button-${el2.id}`).attr('onClick', 'reportCompleted(this)');

                }
                if ((el2.status == true) && el2.state == true) {
                    $(`#statusMessage-${el2.id}`).text("Done");
                    $(`#statusMessage-${el2.id}`).css('color', 'red');
                    $(`#hr-${el2.id}`).css('background', 'red');
                    $(`#report-${el2.id}`).addClass("disabled");
                    $(`#button-${el2.id}`).removeClass('btn-danger');
                    $(`#button-${el2.id}`).text("Done");
                }
                i = i + 1
            })


        })
    }


    handleReport = (current) => {
        console.log(current.id)
        let id = current.id.replace('button-', '');
        firestore.collection("markers").doc(id).update({
            status: true,
        });
        location.reload();
    }
    reportCompleted = (current) => {
        console.log(current.id)
        let id = current.id.replace('button-', '');
        firestore.collection("markers").doc(id).update({
            state: true,
        });
        location.reload();

    }

})