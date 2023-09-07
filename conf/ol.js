import lang from "wac.tax/_/lang.js";
import link from '@w5/link';
import { ver } from "./i18n/var.js";

const cloudflare = 'ok0.pw';

export const 
	I18N_CDN = () => link(cloudflare) + ver + '/' + lang(),
  RES = link('5ok.pw'),
  [USER_TAX_CDN,API,SPI,META] = [...'uafm'].map((i)=>link(i+'.'+cloudflare));
