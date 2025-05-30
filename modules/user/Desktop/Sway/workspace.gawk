$3 == "(focused)" {
	switch(move_type) {
	case "left":
		if ($2 == 1)
			$2=num_of_workspaces+1
		system("sway workspace "$2-1)
		exit
	
	case "right":
		if ($2 == num_of_workspaces)
			$2=0
		system("sway workspace "$2+1)
		exit
	
	case "container_left":
		if ($2 == 1)
			$2=num_of_workspaces+1
		system("sway move container to workspace "$2-1 )
		exit
	
	case "container_right":
		if ($2 == num_of_workspaces)
			$2=0
		system("sway move container to workspace "$2+1)
		exit
	}
}
