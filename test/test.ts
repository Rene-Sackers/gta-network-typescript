/// <reference path="../content/types-gtanetwork/index.d.ts" />

API.disableControlThisFrame(Enums.Controls.Aim);
console.log(Enums.Controls.Aim);

API.createRaycast(new Vector3(), new Vector3(), Enums.IntersectOptions.Everything, null);

var menu = API.createMenu("", "", 0, 0, Enums.MenuAnchor.BottomLeft);
menu.ResetKey(0);//NativeUI.UIMenu_MenuControls.Back)