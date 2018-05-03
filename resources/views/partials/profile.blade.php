<div class="container">
    <div class="row">
        <div class="panel panel-default">
            <br>
            <div class="panel-heading"><h4>User Profile</h4></div>
            <div class="panel-body">
                <div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
                    <img alt="User Pic"
                         src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg"
                         id="profile-image1" class="img-circle img-responsive">
                </div>
                <div class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
                    <div class="container">
                        <h5><?php echo $user->name;?></h5>
                        <?php if($user->id == $id_auth){ ?>
                        <a href="/users/<?php echo $user->id?>/edit_profile" class="btn btn-primary a-btn-slide-text">
                            <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                            <span><strong>Edit Profile</strong></span>
                        </a>
                        <?php } ?>
                        <button type="button" class="btn btn-primary a-btn-slide-text" data-toggle="modal" data-target=".bd-example-modal-sm2">
                            <span><strong>Report user</strong></span>
                        </button>
                    </div>
                    <hr>
                    <ul class="container details">
                        <li><p><span class="fas fa-envelope" style="width:50px;"></span><?php echo $user->email;?></p></li>
                        <li><p><span class="fas fa-birthday-cake" style="width:50px;"></span><?php echo $user->birthdate;?></p></li>
                    </ul>
                    <hr>
                    <div class="col-sm-5 col-xs-6 tital ">Number of warnings: <?php echo $user->nr_warnings;?></div>
                </div>
            </div>
        </div>
        <div class="modal fade bd-example-modal-sm2" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content text-center">
                    <h5 class="modal-title" id="exampleModalLabel">Tell us the reason</h5>
                    <div class="modal-body">
                        <div class="list-group list-group-flush">
                            <form role="form" method="POST" action="/users/<?php echo $user->id ?>/report">
                                {{ csrf_field() }}
                                <input class="form-control" placeholder="Description" id="description" type="text" name="description">
                                <button type="submit" class="btn btn-primary">Send</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
