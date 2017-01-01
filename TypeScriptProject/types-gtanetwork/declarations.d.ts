declare const API: GTANetwork.Javascript.ScriptContext;
import Keys = System.Windows.Forms.Keys;
import Point = System.Drawing.Point;
import Size = System.Drawing.Size;

declare var resource: any;

declare interface IEvent<THandler> {
    connect(handler: THandler): void;
}