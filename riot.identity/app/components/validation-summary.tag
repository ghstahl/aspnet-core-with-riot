<validation-summary>

<div if={this.status.errors} class="text-danger validation-summary-errors"> 
	<ul>
		<li each="{ error in status.errors }">{ error }</li>
	</ul>
</div>
 

<script>
	var self = this;
	self.status = self.opts.status;

</script>
</validation-summary>
