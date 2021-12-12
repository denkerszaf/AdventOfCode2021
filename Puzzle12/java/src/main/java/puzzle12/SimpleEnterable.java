package puzzle12;

import java.util.List;

public class SimpleEnterable implements Enterable {
	
	public boolean mayBeEntered(List<Cave> caves, Cave next) {
		return next.isBig() || !caves.contains(next);
	}

}
