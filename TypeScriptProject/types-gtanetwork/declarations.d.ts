declare const API: GTANetwork.Javascript.ScriptContext;
import Keys = System.Windows.Forms.Keys;

declare var resource: any;

declare interface IEvent<THandler> {
    connect(handler: THandler): void;
}