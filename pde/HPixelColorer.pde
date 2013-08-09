public class HPixelColorer extends HBehavior {

  private HDrawable _target;
	private HPixelColorist _colors;

	public HPixelColorer( HDrawable t, HPixelColorist hpc ) {
		_colors = hpc;
		target(t);
	}

	public HPixelColorer target(HDrawable t) {
		if(t == null) unregister();
		else register();
		_target = t;
		return this;
	}
	public HDrawable target() {
		return _target;
	}
	public void runBehavior(PApplet app) {
		if(_target==null || _colors == null ) return;
		_target.fill( _colors.getColor(_target.x(), _target.y()), 100 );
	}
	public HPixelColorer register() {
		return (HPixelColorer) super.register();
	}
	public HPixelColorer unregister() {
		return (HPixelColorer) super.unregister();
	}
}
