using Microsoft.EntityFrameworkCore;
using SampleSystem.DBEntity.Entities.Masters;

namespace SampleSystem.DBEntity
{
    public class ApplicationDbContext : DbContext
    {
        #region メンバ変数
        /// <summary>
        /// DB接続情報
        /// </summary>
        private string _connectInfo = string.Empty;
        #endregion

        #region コンストラクタ
        /// <summary>
        /// デフォルトコンストラクタ
        /// </summary>
        public ApplicationDbContext () { }

        /// <summary>
        /// コンストラクタ
        /// </summary>
        /// <param name="connentInfo">DB接続情報</param>
        public ApplicationDbContext ( string connentInfo ) : this ()
        {
            _connectInfo = connentInfo;
        }
        #endregion

        #region DBSet
        /// <summary>
        /// ユーザ定義マスタ
        /// </summary>
        public DbSet<m_user_definition> m_user_definitions { get; set; }
        #endregion

        #region 内部メソッド
        /// <summary>
        /// DB接続設定
        /// </summary>
        /// <param name="optionsBuilder">オプションビルダー</param>
        protected override void OnConfiguring ( DbContextOptionsBuilder optionsBuilder )
        {
            // DB接続
            optionsBuilder.UseNpgsql ( _connectInfo );
            // 時間設定
            AppContext.SetSwitch ( "Npgsql.EnableLegacyTimestampBehavior" , true );
        }

        /// <summary>
        /// モデル作成
        /// </summary>
        /// <param name="modelBuilder">モデルビルダー</param>
        protected override void OnModelCreating ( ModelBuilder modelBuilder )
        {
            #region マスタテーブル
            // ユーザ定義マスタ
            modelBuilder.Entity<m_user_definition> ( entity =>
            {
                // 主キー定義
                entity.HasKey ( e => e.id );
                // 論理削除(falseのみ取得)
                entity.HasQueryFilter ( e => !e.is_deleted );
            } );
            #endregion

            #region トランザクションテーブル
            #endregion
        }
        #endregion
    }
}
