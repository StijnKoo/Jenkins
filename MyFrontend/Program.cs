// See https://aka.ms/new-console-template for more information
using System;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("EasyDevOps");
        Console.WriteLine("The current time is " + DateTime.Now);
        Console.WriteLine();

        // ASCII-art van "ITM" met verticale lijnen
        string[] asciiArt = {
            "||||||  ||||||  |||  |||",
            "  ||      ||    || || ||",
            "  ||      ||    ||    ||",
            "  ||      ||    ||    ||",
            "||||||    ||    ||    ||",
        };

        // Print de ASCII-art
        foreach (string line in asciiArt)
        {
            Console.WriteLine(line);
        }
    }
}
