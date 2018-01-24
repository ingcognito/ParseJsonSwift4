//
//  ViewController.swift
//  CSExercise
//
//  Created by mx-mac01 on 2018-01-23.
//  Copyright © 2018 Noah.Ing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let url = URL(string: "https://www.reddit.com/.json")
    var redditPost = [Child]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        downloadJson()
    }

    func downloadJson() {
        URLSession.shared.dataTask(with: url!) { (data, response, err) in

            guard let data = data else { return }

            do {
                let downloadedTitles = try JSONDecoder().decode(RedditJSON.self, from: data)
                self.redditPost = downloadedTitles.data.children

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

                }
                catch let jsonError {
                    print ("There was an error serializing JSON:", jsonError)
                }

            }.resume()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reddit"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditPost.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RedditCell") as? RedditCell else { return UITableViewCell() }

        cell.title.text = redditPost[indexPath.row].data.title
        return cell
    }
}

