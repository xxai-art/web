import uridir from '@w5/uridir'
import viteConf from '@w5/vite-conf'

export default await viteConf(uridir(import.meta))

