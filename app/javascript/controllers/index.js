import { application } from "./application"

import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)
import PrefixedIdController from "./prefixed_id_controller"
application.register("prefixed-id", PrefixedIdController)
