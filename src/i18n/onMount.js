import { ver, posId } from "./var.js";
import i18n from "wac.tax/_/i18n.js";
import { I18N_CDN } from "../conf.js";

const r = i18n.site(ver, posId, I18N_CDN);
export const I18N = r[0];
const onMount = r[1];
export default (func)=>onMount((I18N,lang)=>lang && func(I18N,lang));
