import XCTest
@testable import MGDB


class GetUrlTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testnewGamesURL() {
        let newGamesURL: String = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=id,name,summary,aggregated_rating,developers,publishers,updated_at,release_dates,cover,genres,game_modes,screenshots,url,videos&limit=50&order=updated_at%3Adesc&filter[aggregated_rating][gt]=1"
        
        XCTAssert(GetUrl.newGamesURL == newGamesURL, "NewGames is wrong")
    }
    
    func testNewGamesURLNotNil() {
        XCTAssertNotNil(GetUrl.newGamesURL, "NewGames is nil, check the URL.")
    }
    
    func testGetCoverSmall() {
        let coverSmallURL = URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_small/hh9g1icna6balurtcuuo.png")
        let url = "//images.igdb.com/igdb/image/upload/t_thumb/hh9g1icna6balurtcuuo.png"
        XCTAssertEqual(GetUrl.getCoverSmall(url: url), coverSmallURL, "getCoverSmall set wrong URL")
    }
    
    func testGetCoverSmallIsNil() {
        XCTAssertNil(GetUrl.getCoverSmall(url: nil), "getCoverSmall must be nil")
    }
    
    func testGetCoverMed() {
        let coverSmallURL = URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_med/hh9g1icna6balurtcuuo.png")
        let url = "//images.igdb.com/igdb/image/upload/t_thumb/hh9g1icna6balurtcuuo.png"
        XCTAssertEqual(GetUrl.getCoverMed(url: url), coverSmallURL, "getCoverMed set wrong URL")
    }
    
    func testGetCoverMedIsNil() {
        XCTAssertNil(GetUrl.getCoverMed(url: nil), "getCoverSmall must be nil")
    }
    
    func testGetCoverBig() {
        let coverSmallURL = URL(string: "https://images.igdb.com/igdb/image/upload/t_cover_big/hh9g1icna6balurtcuuo.png")
        let url = "//images.igdb.com/igdb/image/upload/t_thumb/hh9g1icna6balurtcuuo.png"
        XCTAssertEqual(GetUrl.getCoverBig(url: url), coverSmallURL, "getCoverMed set wrong URL")
    }
    
    func testGetCoverBigIsNil() {
        XCTAssertNil(GetUrl.getCoverBig(url: nil), "getCoverSmall must be nil")
    }
    
    func testUrlSearchedGames() {
        let searchGame = "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=id,name,summary,aggregated_rating,developers,publishers,updated_at,release_dates,cover,genres,game_modes,screenshots,url,videos&limit=50&filter[aggregated_rating][gt]=1&search=zelda"
        XCTAssertEqual(GetUrl.getUrlSearchedGames(title: "ZeLdA"), searchGame)
    }
    
    func testUrlSearchedGamesIsEmpty() {
        XCTAssertEqual(GetUrl.getUrlSearchedGames(title: nil), "")
    }
    
    
    
    
    
    
}
