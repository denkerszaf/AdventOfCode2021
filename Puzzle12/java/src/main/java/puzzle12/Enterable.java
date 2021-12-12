package puzzle12;

import java.util.List;

public interface Enterable {
	
	public boolean mayBeEntered(List<Cave> caves, Cave next);

}