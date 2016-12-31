declare const API: GTANetwork.Javascript.ScriptContext;
import Keys = System.Windows.Forms.Keys;

declare interface IEvent<THandler> {
    connect(handler: THandler): void;
}
