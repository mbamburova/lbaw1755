<!DOCTYPE html>
<html lang="en">
<title> My events </title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="../myEvents/my_events.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap-grid.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<body>

<h3> MY EVENTS </h3>
<br>
<div class="container">
    <div class="row">
        <div class="col-sm">
            <div class="container">
                <div class="row">
                    <form>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search by title" name="search">
                            <div class="input-group-btn">
                                <button class="btn btn-default" type="submit">
                                    <i class="glyphicon glyphicon-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="row">
                    <h5>Select the date period:</h5>
                </div>
                <div class="row">
                    <input type="date" class="form-control" id="dateFrom" placeholder="From">
                    <br>
                    <input type="date" class="form-control" id="dateTo" placeholder="To">
                </div>
                <div class="row">
                    <h5>Max km from my location:</h5>
                </div>
                <div class="row">
                    <input type="number" class="form-control" id="km" placeholder="Km">
                </div>

                <br>
                <div class="row">
                    <div class="form-group">
                        <select class="form-control">
                            <option><p>Type of event</p></option>
                            <option><p>Music</p></option>
                            <option><p>Historical</p></option>
                            <option><p>Trip</p></option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <select class="form-control">
                            <option><p>Order by</p></option>
                            <option><p>Date</p></option>
                            <option><p>Alphabetical</p></option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <select class="form-control">
                            <option><p>Order direction </p></option>
                            <option><p>Highest first</p></option>
                            <option><p>Lowest first</p></option>
                        </select>
                    </div>
                </div>

                <br>
                <div class="row">
                    <button type="button" class="btn btn-primary btn-block"><span class="glyphicon glyphicon-search"></span> Filter</button>
                    <button type="button" class="btn btn-default btn-block"><span class="glyphicon glyphicon-remove"></span> Clear</button>
                </div>
            </div>
        </div>
        <div class="col-sm align-content-center">
            <span id="created"> Created by me </span>
            <hr>
            <?php foreach ($user->events as $event) :
                if ($event->pivot->event_user_state == 'Owner') {?>
            <div class="card">
                <img class="card-img-top" src="../../images/myevent.jpg" alt="Card image cap">
                <div class="card-block">
                    <h4> <a href="../event/event.html"> <?php echo $event->title ?> </a></h4>
                    <h6 class="text-muted"> 23 Mar 2018 at 9.30 AM </h6>
                    <h5> Porto's Airport </h5>
                </div>
            </div>
            <?php } else {?>
            <div>
                <p> <?php echo 'OOOPS, this category is empty :/'?> </p>
            </div>
            <?php } endforeach ?>
            <?php if (!($user->events)) {?>
            <div>
                <p> <?php echo 'OOOPS, this category is empty :/'?> </p>
            </div>
            <?php } ?>
            <hr>
        </div>
        <div class="col-sm justify-content-center">
            <span id="going"> Going</span>
            <hr>
            <div class="card">
                <img class="card-img-top" src="../../images/myevent.jpg" alt="Card image cap">
                <div class="card-block">
                    <h4> <a href="../event/event.html"> FEUP party </a></h4>
                    <h6 class="text-muted"> 18 Mar 2018 at 8.30 PM</h6>
                    <h5>FEUP canteen </h5>
                </div>
            </div>
            <br>
            <div class="card">
                <img class="card-img-top" src="../../images/myevent.jpg" alt="Card image cap">
                <div class="card-block">
                    <h4> <a href="../event/event.html"> PHP workshop </a></h4>
                    <h6 class="text-muted"> 10 Mar 2018 at 9.00 AM</h6>
                    <h5> FEUP B003</h5>
                </div>
            </div>
            <hr>
        </div>

        <br>
        <div class="col-sm justify-content-center">
            <span id="ignoring"> Ignoring </span>
            <hr>
            <br>
            <div>
                <br>
                <p> OOOPS, this category is empty :/ </p>
            </div>
        </div>
        <br>
        <div class="col-sm justify-content-center">
            <span id="invited"> Invited to </span>
            <hr>
            <div class="card">
                <img class="card-img-top" src="../../images/myevent.jpg" alt="Card image cap">
                <div class="card-block">
                    <h4> <a href="../event/event.html"> Team dinner </a></h4>
                    <h6 class="text-muted"> 11 April 2018 at 9.00 PM</h6>
                    <h5>Rua- Tapas & Music Bar </h5>
                    <h5>Invited by <a href="../user/profile.html"> joao95 </a> </h5>
                    <br>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            React <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="my_events.html"> Accept </a></li>
                            <li><a href="my_events.html"> Ignore </a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <br>
            <div class="card">
                <img class="card-img-top" src="../../images/myevent.jpg" alt="Card image cap">
                <div class="card-block">
                    <h4> <a href="../event/event.html">Birthday party </a></h4>
                    <h6 class="text-muted"> 16 April 2018 at 9.00 PM </h6>
                    <h5>Club 77</h5>
                    <h5>Invited by <a href="../user/profile.html"> miguel123 </a> </h5>
                    <br>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            React <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a href="my_events.html"> Accept </a></li>
                            <li><a href="my_events.html"> Ignore </a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <hr>
        </div>
        <br>
    </div>
</div>
</body>
<footer class="past">
        <div class="container">
            <ul class="list-inline">
                <li class="list-inline-item"> <a href="past_events.html"> MY PAST EVENTS </a></li>
            </ul>
        </div>
</footer>

</html>