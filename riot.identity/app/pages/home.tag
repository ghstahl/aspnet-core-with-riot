import '../components/itemlist.tag';
<home> 

<div class="col-md-8">
    <section>
        <h4>Use a local account to log in.</h4>
        <hr />
        <form id="myForm" data-toggle="validator" role="form">
            <div class="form-group">
                <label for="inputEmail" class="control-label">Email</label>
                <input name="email" type="email" class="form-control" id="inputEmail" placeholder="Email" data-error="Bruh, that email address is invalid" required>
                <div class="help-block with-errors"></div>
            </div>
            <div class="form-group">
                <label for="inputPassword" class="control-label">Password</label>
                <input name="password" type="password" data-minlength="6" class="form-control" id="inputPassword" placeholder="Password" required>
                <div class="help-block">Minimum of 6 characters</div>
            </div>
            <div class="form-group">
              <button id="submitButton" type="submit" class="btn btn-primary">Login</button>
            </div>

            <p each={items} >
                <a onclick={parent.route} item={this}>{this.title}</a>
            </p>

    

         
      </form>
    </section>
</div>
<div class="col-md-4">
    <section>
        <h4>Use another service to log in.</h4>
        <hr />
                <div>
                    <p>
                        There are no external authentication services configured. See <a href="https://go.microsoft.com/fwlink/?LinkID=532715">this article</a>
                        for details on setting up this ASP.NET application to support logging in via external services.
                    </p>
                </div>
    </section>
</div>
 

<script>
	var self = this;
	self.name = 'home';
    self.items =  [
          { title: 'Register as a new user?', route: '/main/register'},
          { title: 'Forgot your password?', route: '/main/forgot'}
      ];
    self.onSubmit = (e) =>{
        let myForm = $('#myForm');
        let data = self.toJSONString(myForm[0]);

        var disabled = $('#submitButton').hasClass("disabled");
        if(!disabled) {
            console.log('valid');
            e.preventDefault();
            riot.control.trigger(riot.EVT.accountStore.in.login,data);

        }else{
            console.log('invalid');
        }
    }
    self.route = (evt) => {
        riot.control.trigger(riot.EVT.routeStore.in.routeDispatch,evt.item.route);
      };
    self.toJSONString = ( form ) =>{
        var obj = {};
        var elements = form.querySelectorAll( "input, select, textarea" );
        for( var i = 0; i < elements.length; ++i ) {
            var element = elements[i];
            var name = element.name;
            var value = element.value;

            if( name ) {
                obj[ name ] = value;
            }
        }

        return JSON.stringify( obj );
    }

	self.on('mount', function() {
        let myForm = $('#myForm');
        myForm.validator();
        myForm.on('submit', self.onSubmit);
    
    })
	self.on('unmount', function() {
    	
    })

	self.generateAnError = () => {
  		riot.control.trigger(riot.EVT.errorStore.in.errorCatchAll,{code:'dancingLights-143523'});
  	};
</script>

</home>