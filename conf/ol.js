import lang from "wac.tax/_/lang.js";
import link from '@w5/link';
import { ver } from "./i18n/var.js";

const cloudflare = '.ok0.pw'
export const 
  USER_TAX_CDN = link('u'+cloudflare),
	I18N_CDN = () => link('8'+cloudflare) + ver + '/' + lang(),
	API = link('a'+cloudflare),
  SPI = link('f'+cloudflare),
  RES = link('5ok.pw'),
  META = link('m'+cloudflare);
  //SPI = link('i-01.eu.org'),
  //META = link('u-01.eu.org');
