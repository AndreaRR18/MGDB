import Foundation
import UIKit

let darkSouls = Game(
    name: "Dark Soul",
    genres: Genres.rolePlaying.rawValue,
    firstReleaseDate: "2011",
    developers: Developers.fromSoftware.rawValue,
    cover: UIImage(named: "darksouls.png")!)

let theWitcher = Game(
    name: "The Witcher III: Wild Hunt",
    genres: Genres.adventure.rawValue,
    firstReleaseDate: "2015",
    developers: Developers.cdProjectRed.rawValue,
    cover: UIImage(named: "witcheriii.png")!)

let gtaV = Game(
    name: "GTA V",
    genres: Genres.shooter.rawValue,
    firstReleaseDate: "2013",
    developers: Developers.rockStarNorth.rawValue,
    cover: UIImage(named: "gtav.png")!)

let noManSky = Game(
    name: "No Man Sky",
    genres: Genres.rolePlaying.rawValue,
    firstReleaseDate: "2016",
    developers: Developers.helloGames.rawValue,
    cover: UIImage(named: "nomansky.jpeg")!)

let superMarioMaker = Game(
    name: "Super Mario Maker",
    genres: Genres.platform.rawValue,
    firstReleaseDate: "2016",
    developers: Developers.nintendo.rawValue,
    cover: UIImage(named: "mariomaker.jpeg")!)
