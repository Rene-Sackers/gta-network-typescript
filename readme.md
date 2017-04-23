# GTA Network TypeScript Definitions

## About

Because dynamically typed languages are sometimes unpredictible, hard to maintain, and require mental mapping, and intellisense generally doesn't work well in JavaScript, I've created these TypeScript definition files for the GTA Network mod.

![Intellisense Example](http://i.imgur.com/6vaaSLI.png)

GTA Network uses [ClearScript](https://clearscript.codeplex.com/), this means that some C# objects are used, and available in JavaScript, like System.Array.  
For this, I have used [ToTypeScriptD](https://github.com/ToTypeScriptD/ToTypeScriptD) by [staxmanade](https://github.com/staxmanade). It generated most of the System.* definition libraries, after some modification of the code.

## Using the definitions

1. Install the [NuGet Package](https://www.nuget.org/packages/types-gtanetwork/) in your project, either via Visual Studio's NuGet package manager, or command line:
```
Install-Package types-gtanetwork
```

2. Create your .ts file that you want to use the definitions in.
3. Drag the `index.d.ts` file in the `types-gtanetwork` folder into your code pane, with your .ts file open

![Link Definition](http://i.imgur.com/w7mVDBr.png)

This should add a reference to the `index.d.ts` file in your .ts file, and it should look something like this:

    /// <reference path="../types-gtanetwork/index.d.ts" />

If you aren't using an editor that'll do this for you, manually add this line to the top of your .ts file, and correct the path.

## TypeScript project setup

Due to the nature of the GTA Network mod, it's suggested to compile your TypeScript files to a single file, and initialize everything after the `API.onResourceStart` event gets triggered.

Here's a reccommended `tsconfig.json` file:

```json
{
    "compilerOptions": {
        "noImplicitAny": true,
        "noEmitOnError": true,
        "removeComments": false,
        "sourceMap": true,
        "target": "es6",
        "outFile": "bin/Compiled.js"
    },
    "compileOnSave": true
}
```

This will compile all the .ts files in the folder that the .json file is placed into in VisualStudio, to a single `Compiled.js` file. This allows you to have separate files for each class, but without having to include a lot of .js files in `meta.xml`.

However, the order at which the files are put into the single compiled JavaScript isn't certain, therefore, you should only call code from the files after `API.onResourceStart`.

For example:

```js
// resources/MyResource/Main.ts
class Main {
    private anotherClass: AnotherClass;

    constructor() {
        this.anotherClass = new AnotherClass();

        API.onUpdate.connect(this.onUpdateHandler);
    }

    private onUpdateHandler = () => {
        this.AnotherClass.doSomething();
    }
}

API.onResourceStart.connect(() => {
    new Main();
});
```

```js
// resources/MyResource/AnotherClass.ts
class AnotherClass {
    public doSomething = () => {
        // ...
    }
}
```

This will call the constructor of the `Main` class, which will in turn construct the `AnotherClass` object.  
Because we are doing this in an `API.onResourceStart` it means all code has loaded, resolving the issue where `Main` might be defined BEFORE `AnotherClass` in the output .js file, preventing `AnotherClass is not defined` errors.

Just beware that doing it this way, also means that everything will be in the same exact namespace. So defining 2 variables or classes in the root of your file with the exact same name, will either cause errors, or unexpected behavior with one overriding the other.  
Make sure you either put stuff in namespaces, or you give everything a unique name.

Personally, I like to only work from classes. So 1 file = 1 class, and all code is within classes. That way (if you also make sure the class name is equal to the file name, as it should be), you can never write duplicate class or variable names.

## Feedback and further development

I plan to keep these definitions up to date for as long as I work with GTA Network myself.

If you find issues, please open an issue on this project on [GitHub](https://github.com/Rene-Sackers/gta-network-typescript/issues), and if you want to be a very nice person, you can even create a pull request, and I'll consider accepting it :)