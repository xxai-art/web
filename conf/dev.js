import lang from "wac.tax/_/lang.js";
import link from '@w5/link';

const cloudflare = '.ok0.pw'
export const 
	I18N_CDN = () => "/.18/" + lang(),
	// API = "https://api.wac.tax/";
	API = link("localhost"),
	// API = link("127.0.0.1:8880"),
  // SPI = link('127.0.0.1:8080'),
  USER_TAX_CDN = link('u'+cloudflare),
  SPI = link('f'+cloudflare),
  RES = link('5ok.pw'),
  META = link('m'+cloudflare);
